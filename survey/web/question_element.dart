// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library survey.web.question;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:survey/models.dart';

/*
 *  The QuestionElement view. Use this to set the question text, optionally
 *  provide answer options to the user, and pick the widget that the user sees.
 */
@CustomTag('question-element')
class QuestionElement extends PolymerElement with ObservableMixin {
  static const TEXT = 'Use a text field';
  static const ONE_FROM_MANY = 'Select one from many options';
  static const MANY_FROM_MANY = 'Select many from many options';

  bool get applyAuthorStyles => true;

  @observable Question question = new Question();
  @observable bool editing = true;
  @observable String errorMessage = '';
  @observable List<String> widgetOptions = [TEXT, ONE_FROM_MANY,
                                            MANY_FROM_MANY];
  @observable int widgetSelectedIndex = 0;
  @observable List<String> optionInputs = toObservable(['']);

  // TODO: remove once it gets easier to pass attributes to polymer elements.
  @observable List multiSelectAttrs;

  @observable bool get usingTextWidget => widgetSelectedIndex == 0;

  edit() {
    editing = true;
    errorMessage = '';
    optionInputs.add('');
  }

  addEmptyInput(Event e, var detail, Element sender) {
    e.preventDefault();
    optionInputs.add('');
  }

  void getInputValues() {
    var root = getShadowRoot('question-element');
    var ul = root.query('#input-container');
    var inputs = ul.queryAll('input');

    optionInputs.clear();
    inputs.forEach((input) {
      var val = input.value.trim();
      if (val.isNotEmpty) {
        optionInputs.add(val);
      }
    });
  }

  bool validate() {
    bool valid = true;
    if (question.isValid) {
      if (!usingTextWidget && optionInputs.length == 0) {
        errorMessage = 'You didn\'t add any options';
        valid = false;
      }
    } else {
      errorMessage = 'You forgot to add the question text';
      valid = false;
    }
    return valid;
  }

  show(Event e, var detail, Element sender) {
    e.preventDefault();
    if (!usingTextWidget) {
      getInputValues();
    }

    if (validate()) {
      question.answerOptions = optionInputs.where((opt) {
        return opt.isNotEmpty;
      }).toList();
      multiSelectAttrs = toObservable([question.answerOptions, true]);
      editing = false;
    } else {
      optionInputs.add('');
    }
  }

  delete(Event e, var detail, Element sender) {
    if (window.confirm('Are you sure you want to delete this question?')) {
      appModel.questions.remove(question);
    }
  }

  setSelectionAnswers(Event e, var detail, Element sender) {
    e.preventDefault();
    question.answers = detail;
  }

  setTextAnswer(Event e, var detail, var sender) {
    e.preventDefault();
    question.answers = [sender.value.trim()];
  }
}