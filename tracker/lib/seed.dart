library seed;

import 'models.dart';

List data = [
    new Task('Create a skeletal polymer app',
        description: '''This should just be a simple coat-hanger.
            Just enough to get started.''',
        points: 2,
        status: 'completed'),

    new Task('Create a seeds file',
        description: '''Put all data for the project into this file
            and import the data when initializing the app''',
        points: 2,
        status: 'completed'),

    new Task('Sort tasks by status',
      description: '''User a 3-column layout. column1 shows current tasks,
          column2 shows pending tasks, column3 show completed tasks''',
      points: 3,
      status: 'current'),

    new Task('Use Bootstrap 3 for layout',
        description: '''User a 3-column layout that collapses into a 
            single column on a small mobile device''',
        points: 2)

    ];