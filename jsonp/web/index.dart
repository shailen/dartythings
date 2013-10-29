// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library jsonp_sample;

import 'dart:html';
import 'dart:js';

const List<String> FIELDS = const ['name', 'description', 'size',
                                   'watchers', 'forks'];

TableElement table;
TableSectionElement thead, tbody;
var repo;

void createTable() {
  table = new TableElement();
  table.classes.add('table');
  table.classes.add('table-bordered');
  table.classes.add('table-striped');
  thead = table.createTHead();
  tbody = table.createTBody();
}

populateTableHead() {
  var tr = new TableRowElement();
  for (var field in FIELDS) {
    var th = new Element.tag('th');
    th.text = field;
    tr.append(th);
  }
  thead.append(tr);
}

populateTableBody() {
  var tr = new TableRowElement();
  for (var field in FIELDS) {
    var td = new TableCellElement();
    if (field == 'name') {
      var link = new AnchorElement();
      link.href = repo['html_url'];
      link.text = repo[field];
      td.append(link);
    } else {
      td.text = repo[field].toString();
    }
    tr.append(td);
  }
  tbody.append(tr);
}

void main() {

  //  Create a jsObject to handle the response.
  context['processData'] = (response) {
    createTable();
    populateTableHead();

    var count = 0;

    while (true) {
      // Process the array containing the response data.
      repo = response['data'][count];
      if (repo == null) {
        querySelector('.container').append(table);
        return;
      }
      count++;
      populateTableBody();
    }
  };

  ScriptElement script = new Element.tag("script");
  script.src = "https://api.github.com/users/dart-lang/repos?callback=processData";
  document.body.children.add(script);
}
