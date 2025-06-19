from . import db

# Association table for many-to-many relationship between notes and tags
note_tags = db.Table('note_tags',
    db.Column('note_id', db.Integer, db.ForeignKey('note.id'), primary_key=True),
    db.Column('tag_id', db.Integer, db.ForeignKey('tag.id'), primary_key=True)
)

class Note(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.Text, nullable=False)

    # Relationship to Tag via association table
    tags = db.relationship('Tag', secondary=note_tags, back_populates='notes')

class Tag(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), unique=True, nullable=False)

    # Relationship to Note via association table
    notes = db.relationship('Note', secondary=note_tags, back_populates='tags')
