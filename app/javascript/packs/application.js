// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require plyr
//= require jquery_ujs

// import ActiveStorageDragAndDrop from 'active_storage_drag_and_drop'

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

//= require select_all.js
//= require plyr
require("alpinejs")
require("chartkick")
require("chart.js")
require("jquery")
require("plyr")
require("select2")
require("focus-trap")

require("trix")
require("@rails/actiontext")

import '../css/application.css'

require('tailwindcss')('./app/javascript/css/tailwind.js'),
    require('autoprefixer')

// lauching plyr
$(document).on("turbolinks:load", function () {
    const player = new Plyr('#player');
});

document.addEventListener("turbolinks:load", function () {
    // fynamic search on table
    function myFunction() {
        // Declare variables
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("myInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("myTable");
        tr = table.getElementsByTagName("tr");

        // Loop through all table rows, and hide those who don't match the search query
        for (i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[0];
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }
});

$(function () {
    $("#selectAll").select_all();
});

// adding notifications
Notification.requestPermission().then(
    function (result) {

    }
)

// including notifications
const Uppy = require('@uppy/core')
const Dashboard = require('@uppy/dashboard')
const ActiveStorageUpload = require('@excid3/uppy-activestorage-upload')

require('@uppy/core/dist/style.css')
require('@uppy/dashboard/dist/style.css')

document.addEventListener('turbolinks:load', () => {
    document.querySelectorAll('[data-uppy]').forEach(element => setupUppy(element))
})

function setupUppy(element) {
    let trigger = element.querySelector('[data-behavior="uppy-trigger"]')
    let form = element.closest('form')
    let direct_upload_url = document.querySelector("meta[name='direct-upload-url']").getAttribute("content")
    let field_name = element.dataset.uppy

    trigger.addEventListener("click", (event) => event.preventDefault())

    let uppy = Uppy({
        autoProceed: true,
        allowMultipleUploads: false,
        logger: Uppy.debugLogger
    })

    uppy.use(ActiveStorageUpload, {
        directUploadUrl: direct_upload_url
    })

    uppy.use(Dashboard, {
        trigger: trigger,
        closeAfterFinish: true,
    })

    uppy.on('complete', (result) => {
        // Rails.ajax
        // or show a preview:
        element.querySelectorAll('[data-pending-upload]').forEach(element => element.parentNode.removeChild(element))

        result.successful.forEach(file => {
            appendUploadedFile(element, file, field_name)
            setPreview(element, file)
        })

        uppy.reset()
    })
}

function appendUploadedFile(element, file, field_name) {
    const hiddenField = document.createElement('input')

    hiddenField.setAttribute('type', 'hidden')
    hiddenField.setAttribute('name', field_name)
    hiddenField.setAttribute('data-pending-upload', true)
    hiddenField.setAttribute('value', file.response.signed_id)

    element.appendChild(hiddenField)
}

function setPreview(element, file) {
    let preview = element.querySelector('[data-behavior="uppy-preview"]')
    if (preview) {
        let src = (file.preview) ? file.preview : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSpj0DBTVsaja01_xWh37bcutvpd7rh7zEd528HD0d_l6A73osY"
        preview.src = src
    }
}


addEventListener("direct-upload:initialize", event => {
    const {target, detail} = event
    const {id, file} = detail
    target.insertAdjacentHTML("beforebegin", `
    <div id="direct-upload-${id}" class="direct-upload direct-upload--pending">
      <div id="direct-upload-progress-${id}" class="direct-upload__progress" style="width: 0%"></div>
      <span class="direct-upload__filename"></span>
    </div>
  `)
    target.previousElementSibling.querySelector(`.direct-upload__filename`).textContent = file.name
})

addEventListener("direct-upload:start", event => {
    const {id} = event.detail
    const element = document.getElementById(`direct-upload-${id}`)
    element.classList.remove("direct-upload--pending")
})

addEventListener("direct-upload:progress", event => {
    const {id, progress} = event.detail
    const progressElement = document.getElementById(`direct-upload-progress-${id}`)
    progressElement.style.width = `${progress}%`
})

addEventListener("direct-upload:error", event => {
    event.preventDefault()
    const {id, error} = event.detail
    const element = document.getElementById(`direct-upload-${id}`)
    element.classList.add("direct-upload--error")
    element.setAttribute("title", error)
})

addEventListener("direct-upload:end", event => {
    const {id} = event.detail
    const element = document.getElementById(`direct-upload-${id}`)
    element.classList.add("direct-upload--complete")
})
import "controllers"
