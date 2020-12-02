// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
    static targets = ["output"]

    connect() {
        var video = document.getElementById('video');
        //this.outputTarget.textContent = 'Hello, Stimulus!'
        this.apiKey = video.dataset.apikey //this.data.get('apiKey')
        this.sessionId = video.dataset.sessionid //this.data.get('sessionId')
        this.token = video.dataset.token //this.data.get('token')

        this.initializeSession()
    }

    disconnect() {
        if (this.session) {
            this.session.disconnect()
        }
    }

    // try to chare screen
    share() {
        var share = document.getElementById('share');
        this.action = share.dataset.share
        console.log('Action shared init');
        alert('hello shared');

        OT.checkScreenSharingCapability(function(response) {
            if(!response.supported || response.extensionRegistered === false) {
                // This browser does not support screen sharing.
            } else if (response.extensionInstalled === false) {
                // Prompt to install the extension.
            } else {
                // Screen sharing is available. Publish the screen.
                var publisher = OT.initPublisher('screen-preview',
                    {videoSource: 'screen'},
                    function(error) {
                        if (error) {
                            // Look at error.message to see what went wrong.
                        } else {
                            session.publish(publisher, function(error) {
                                if (error) {
                                    // Look error.message to see what went wrong.
                                }
                            });
                        }
                    }
                );
            }
        });

        // OT.checkScreenSharingCapability(function(response){
        //     if (!response.supported || response.extentionRegistered === false){
        //
        //     } else {
        //         var publisher = OT.initPublisher('screen-preview', {
        //             videoSource: 'screen',
        //             maxResolution: {width: 1280, height: 720},
        //             fitMode: "contain",
        //             publishAudio: false
        //             },
        //             function(error){
        //             if (error){
        //                 console.error(error.message);
        //             } else {
        //
        //             }
        //         });
        //     }
        // })
    }

    initializeSession() {
        var video = document.getElementById('video');

        this.session = OT.initSession(this.apiKey, this.sessionId)

        this.session.on('streamCreated', this.streamCreated.bind(this))

        this.session.on('mediaStopped', this.mediaStopped.bind(this))

        this.publisher = OT.initPublisher(this.element, {
            insertMode: 'append',
            width: '100%',
            height: "100%",
            name: video.dataset.name, //this.data.get('name'),
            showControls: true,
            fitMode: "contain",
            maxResolution: {width: 1280, height: 720 },
            //videoSource: 'screen'
        }, this.handleError.bind(this))

        this.session.connect(this.token, this.streamConnected.bind(this))

        // Receive a message and append it to the history
        var msgHistory = document.querySelector('#history');
        session.on('signal:msg', function signalCallback(event) {
            var msg = document.createElement('p');
            msg.textContent = event.data;
            msg.className = event.from.connectionId === session.connection.connectionId ? 'mine' : 'theirs';
            msgHistory.appendChild(msg);
            msg.scrollIntoView();
        });
    }




    streamConnected(error) {
        if (error) {
            this.handleError.bind(this)
        } else {
            this.session.publish(this.publisher, this.handleError.bind(this))
        }
    }

    mediaStopped(event) {
        console.log("un utilisateur à suspendu sa session!");
        alert("Un utilisateur à quitter la salle de classe");
    }

    streamDestroyed(event) {
        if (event.reason === 'mediaStopped') {
            //user stop sharing
        } else if (event.reason === 'forceUnpublished') {
            // a moderator forced a user to stop sharing
        }
    }

    streamCreated(event) {
        console.log('New user connected to stream ...');
        var subOptions = {insertMode: 'append'};
        if(event.stream.videoType === 'screen') {
            //session.subscribe(event.stream, 'screens', subOptions);
            this.session.subscribe(event.stream, this.element, {
                insertMode: 'append',
                width: '100%',
                height: '100%',
                showControls: true,
                fitMode: "contain",
                videoSource: 'screen'
            }, this.handleError.bind(this))
        } else {
            //session.subscribe(event.stream, 'people', subOptions);
            this.session.subscribe(event.stream, this.element, {
                insertMode: 'append',
                width: '100%',
                height: '100%',
                showControls: true,
                fitMode: "contain"
            }, this.handleError.bind(this))
        }


        // this.session.subscribe(event.stream, this.element, {
        //     insertMode: 'append',
        //     width: '100%',
        //     height: '100%',
        //     showControls: true,
        //     fitMode: "contain"
        // }, this.handleError.bind(this))
    }

    handleError(error) {
        if (error) {
            //alert("Une erreur est survenu : "+error.message);
            console.error(error.message)
        }
    }
}
