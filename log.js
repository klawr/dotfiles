const log = (function() {
    let log = "";
    return {
        add: function (...args) {
            for(let arg of args)
                log += arg + "\n";
        },
        show: function () {
            this.add(...arguments),
            alert(log); },
        clear: function () {
            log = '';
        },
        html: function() {
            log.add(...arguments);
            _log = log.replace(/\n/g, '</br>');
            if(document.getElementById("log"))
                document.getElementById("log").innerHTML = _log;
            else
                alert("No log-element!");
            _log = "";
        },
        separator: function(num, first=true) {
            if((first && log === "") || log !== "")
                this.add("".padStart(num,"-"));
        }
    }
})();