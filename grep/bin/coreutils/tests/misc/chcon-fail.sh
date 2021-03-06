#!/bin/sh
# Ensure that chcon fails when it should.
# These tests don't use any actual SE Linux syscalls.

# Copyright (C) 2007-2013 Free Software Foundation, Inc.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

. "${srcdir=.}/tests/init.sh"; path_prepend_ ./src
print_ver_ chcon


# neither context nor file
chcon 2> /dev/null && fail=1

# No file
chcon CON 2> /dev/null && fail=1

# No file
touch f
chcon --reference=f 2> /dev/null && fail=1

# No file
chcon -u anyone 2> /dev/null && fail=1

Exit $fail
