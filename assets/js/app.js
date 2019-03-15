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
    function create_action_td(task_id, tb_id) {
        return $('<td>').append(
            $('<button>')
                .addClass("btn").addClass("btn-danger")
                .attr("type", "button")
                .text("Delete").data("task_id", task_id).data("id", tb_id)
                .click(delete_action)
        );
    }

    function delete_action(ev) {
        var tb_id = $(ev.target).data("id");
        var task_id = $(ev.target).data("task_id");
        $.ajax(timeblock_path + "/" + tb_id, {
            method: "delete",
            dataType: "json",
            success: (resp) => {
                update_timeblocks(task_id);
            }
        });
    }

    function update_timeblocks(task_id) {
        $.ajax(`${timeblock_path}?task_id=${task_id}`, {
            method: "get",
            dataType: "json",
            contentType: "application/json; charset=UTF_8",
            data: "",
            success: (resp) => {
                $("#timeblocksTable tbody").empty();
                $.each(resp.data, function(i, item) {
                    var row = $('<tr>').append(
                        $('<td>').text(item.start.replace("T", " ")),
                        $('<td>').text(item.end.replace("T", " ")),
                        create_action_td(task_id, item.id))
                        .data("id", item.id);
                    $("#timeblocksTable tbody").append(row);
                });
            }
        });
    }

    if (window.timeblock_task_id) {
        update_timeblocks(window.timeblock_task_id);
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
        if (window.timeblock_started) {
            return;
        }
        let task_id = $(ev.target).data('task-id');
        let now = new Date().toISOString().split('.')[0];
        let text = JSON.stringify({
            timeblock: {
                start: now,
                end: now,
                task_id: task_id
            },
            set_midblock: true
        });
        console.log(text);
        $.ajax(timeblock_path, {
            method: "post",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: text,
            success: (resp) => {
                update_timeblocks(task_id);
                window.timeblock_started = true;
                window.timeblock_last_id = resp.data.id;
                $("#timeblock-status").text("Started tracking at " + now);
            },
        });
    });

    $("#endButton").click((ev) => {
        if (!window.timeblock_started) {
            return;
        }
        let task_id = $(ev.target).data('task-id');
        let now = new Date().toISOString().split('.')[0];
        let tb_id = window.timeblock_last_id;
        let text = JSON.stringify({
            timeblock: {
                end: now,
            },
            set_midblock: true
        });
        console.log(text);
        $.ajax(timeblock_path + "/" + tb_id, {
            method: "patch",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: text,
            success: (resp) => {
                update_timeblocks(task_id);
                window.timeblock_started = false;
                $("#timeblock-status").text("No time block started.");
            },
        });

    });
    //end button
});
