let months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
] 
const fixDateTime = function (date) {
    if (date != "") {
        date = new Date(date);
        let minutes = date.getMinutes();
        minutes = minutes < 10 ? "0" + minutes : minutes;
        let goodDate =
            months[date.getMonth()] +
            " " +
            date.getDate() +
            " " +
            date.getHours() +
            ":" +
            minutes;
        return goodDate;
    }
}

module.exports = {
    fixDateTime
}
