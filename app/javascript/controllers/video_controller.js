// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import {Controller} from "stimulus"

export default class extends Controller {
    static targets = ["output"]

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
        //alert('hello shared');

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
}
