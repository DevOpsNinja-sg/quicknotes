from flask import render_template, request, jsonify
from . import db
from .models import Note
from flask import current_app as app
import markdown2
from .models import Note, Tag


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/notes', methods=['GET', 'POST'])
def handle_notes():
    if request.method == 'POST':
        data = request.get_json()
        content = data.get('content', '').strip()
        tags_input = data.get('tags', [])
        if not content:
            return jsonify({'error': 'Content required'}), 400

        tags = []
        for tag_name in tags_input:
            tag = Tag.query.filter_by(name=tag_name).first()
            if not tag:
                tag = Tag(name=tag_name)
                db.session.add(tag)
            tags.append(tag)

        new_note = Note(content=content, tags=tags)
        db.session.add(new_note)
        db.session.commit()
        return jsonify({'id': new_note.id, 'content': new_note.content, 'tags': [t.name for t in new_note.tags]}), 201

    notes = Note.query.all()
    return jsonify([
        {
            'id': n.id,
            'content': markdown2.markdown(n.content),
            'raw': n.content,
            'tags': [t.name for t in n.tags]
        }
        for n in notes
    ])


@app.route('/api/notes/<int:note_id>', methods=['DELETE'])
def delete_note(note_id):
    note = Note.query.get(note_id)
    if note:
        db.session.delete(note)
        db.session.commit()
        return '', 204
    return jsonify({'error': 'Note not found'}), 404
