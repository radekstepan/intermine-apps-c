Client for embedding InterMine widgets (ws_widgets branch only!).

## Requirements:
### To Run:

- Google API (included)
- jQuery (included)
- underscore.js (included)
- backbone.js (included)

### To Compile/Test:
- CoffeeScript & [eco](https://github.com/sstephenson/eco) templating
- [uglify-js](https://github.com/mishoo/UglifyJS) to compress templates

## Configure:
**Create a new Widgets** instance in `index.html` pointing to a service:

```javascript
var widgets = new Widgets("http://aragorn.flymine.org:8080/flymine/service/");
```

**Choose which widgets** you want to load:

```javascript
// Load all Widgets:
widgets.all('Gene', 'myList', '#all-widgets');
// Load a specific Chart Widget:
widgets.chart('flyfish', 'myList', '#widget-1');
// Load a specific Enrichment Widget:
widgets.enrichment('pathway_enrichment', 'myList', '#widget-2');
```

## Use:
1. Start a simple HTTP server using `.webserver.sh`.
2. Visit [http://0.0.0.0:1111/](http://0.0.0.0:1111/)

## Compile:
1. Install dependencies `npm install -d`.
2. Run `cake compile:main` to compile widgets and templates into one target. Check optional parameters by running `cake`.

## Test:
1. Run `cake compile:tests` to compile the test spec.
2. Start a simple HTTP server using `.webserver.sh`.
3. Visit [http://0.0.0.0:1111/tests/](http://0.0.0.0:1111/tests/) that automatically runs [Jasmine](http://pivotal.github.com/jasmine/) tests.

## Release to InterMine:

**Configure** the `Cakefile` with paths to your own InterMine SVN:

```coffeescript
# Path to InterMine SVN output.
INTERMINE =
    ROOT: "/home/rs676/svn/ws_widgets"
    OUTPUT: "intermine/webapp/main/resources/webapp/js/widget.js"
```

### With Commit

**Execute** the release task by running `cake --commit "message" release`; this will commit the `widget.js` file with your custom message.

## Example:
![image](https://raw.github.com/radekstepan/intermine-widget-client/master/example.png)

## Q&A:

### I want to define a custom behavior when clicking on Chart Widget.

Will run a PathQuery against a mine and display its results in HTML.

```javascript```
var options = {
    selectCb: function(pq) {
        window.open(mineURL + "/service/query/results?query=" + encodeURIComponent(pq) + "&format=html");
    }
};
widgets.chart('flyfish', 'myList', '#widget', options);
```

### I want to define a custom behavior when clicking on one of the matches in Enrichment Widget.

Will open a Report page on a given mine for the match selected.

```javascript```
var options = {
    matchCb: function(id, type) {
        window.open(mineURL + "/portal.do?class=" + type + "&externalids=" + id);
    }
};
widgets.enrichment('pathway_enrichment', 'myList', '#widget', options);
```

### I want to hide the title or description of a widget.

```javascript```
var options = {
    "title": false,
    "description": false
};
widgets.enrichment('pathway_enrichment', 'myList', '#widget', options);
```