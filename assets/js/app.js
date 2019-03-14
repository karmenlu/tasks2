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
                $("#timeblocksTable").empty();
                $.each(resp.data, function(i, item) {
                    var row = $('<tr>').append(
                        $('<td>').text(item.start),
                        $('<td>').text(item.end))
                        .data("id", item.id);
                    $("#timeblocksTable").append(row);
                });
            }
        });
    }

    // create-timeblock-button
    $('#createBlockButton').click((ev) => {
        let startDate= $('#starttime-date').val();
        let startTime = $('#starttime-time').val(); 
        let endDate = $('#endtime-date').val();
        let endTime = $('#endtime-time').val(); 
        let task_id = $(ev.target).data('task-id');

        let text = JSON.stringify({
            timeblock: {
                start: startDate + "T" + startTime + ":00",
                end: endDate + "T" + endTime + ":00",
                task_id: task_id,

            },
        });

        $.ajax(timeblock_path, {
            method: "post",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: text,
            success: (resp) => {
                update_timeblocks(task_id);
            },
        });
    });




    //start button
    $('#startButton').click((ev) => {
        let task_id = $(ev.target).data('task-id');

        let text = JSON.stringify({
            timeblock: {
                start: new Date().toISOString().split('.')[0],
                end: null,
                task_id: task_id,

            },
        });

        $.ajax(timeblock_path, {
            method: "post",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: text,
            success: (resp) => {
                update_timeblocks(task_id);
            },
        });
    });
    //end button
});
