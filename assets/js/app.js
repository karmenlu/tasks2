// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";
import jQuery from 'jquery';
window.jQuery = window.$ = jQuery;
import "bootstrap";
import _ from "lodash";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

$(function () {
    function update_timeblocks(task_id) {
        $.ajax(`${timeblock_path}?task_id=${task_id}`, {
            method: "get",
            dataType: "json",
            contentType: "application/json; charset=UTF_8",
            data: "",
            success: (resp) => {
                $("#timeblocks").empty();
                $.each(resp.data, function(i, item) {
                    var row = $('<tr>').append(
                        $('<td>').text(item.start),
                        $('<td>').text(item.end))
                        .data("id", item.id);
                    $("#timeblocks").append(row);
                });
            }
        });
        //TODO: complete ajax function for updating timeblocks
    }
});
