#!/usr/bin/env python3
# pylint: disable=invalid-name,redefined-outer-name
###############################################################################
#
# Copyright 2016 - 2021, Thomas Lauf, Paul Beckingham, Federico Hernandez.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# https://www.opensource.org/licenses/mit-license.php
#
###############################################################################
from __future__ import print_function
import json
import subprocess
import sys
# Hook should extract all of the following for use as Timewarrior tags:
#   UUID
#   Project
#   Tags
#   Description
#   UDAs
input_stream = sys.stdin.buffer
# Make no changes to the task, simply observe.
old = json.loads(input_stream.readline().decode("utf-8", errors="replace"))
new = json.loads(input_stream.readline().decode("utf-8", errors="replace"))
print(json.dumps(new))
def extract_tags_from(json_obj):
    # Extract attributes for use as tags.
    tags = [json_obj['uuid'], json_obj['description']]
    if 'project' in json_obj:
        tags.append(json_obj['project'])
    if 'tags' in json_obj:
        tags.extend(json_obj['tags'])
    return tags
def extract_annotation_from(json_obj):
    if 'annotations' not in json_obj:
        return '\'\''
    return json_obj['annotations'][0]['description']
start_or_stop = ''
# Started task.
if 'start' in new and 'start' not in old:
    start_or_stop = 'start'
# Stopped task.
elif ('start' not in new or 'end' in new) and 'start' in old:
    start_or_stop = 'stop'
if start_or_stop:
    tags = extract_tags_from(new)
    subprocess.call(['timew', start_or_stop] + tags + [':yes'])
# Modifications to task other than start/stop
elif 'start' in new and 'start' in old:
    old_tags = extract_tags_from(old)
    new_tags = extract_tags_from(new)
    if old_tags != new_tags:
        subprocess.call(['timew', 'untag', '@1'] + old_tags + [':yes'])
        subprocess.call(['timew', 'tag', '@1'] + new_tags + [':yes'])
    old_annotation = extract_annotation_from(old)
    new_annotation = extract_annotation_from(new)
    if old_annotation != new_annotation:
        subprocess.call(['timew', 'annotate', '@1', new_annotation])
