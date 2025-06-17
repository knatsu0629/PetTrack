// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import $ from 'jquery';
import 'jquery-jpostal-ja';

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 
import "./map"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

function jpostal() {
  $('#zipcode').jpostal({
    postcode : ['#zipcode'],
    address : {
      '#lost_pet_address': '%3%4%5'
    }
  });
}

function initJpostalPlugin() {
  console.log("jpostal plugin initialization started.");

  const zipcodeElement = $('#zipcode');
  if (zipcodeElement.length) {
    console.log("Found #zipcode element. Applying jpostal plugin.");

    zipcodeElement.jpostal({
      postcode : ['#zipcode'],
      address : {
        '#lost_pet_address': '%3%4%5'
      }
    });
    console.log("jpostal plugin applied to #zipcode."); // プラグイン適用完了をログ

  } else {
    console.log("Could not find #zipcode element for jpostal plugin application."); // 要素が見つからなかったことをログ
  }
}

$(document).on("turbolinks:load", initJpostalPlugin);