class NoteModel {
  int? notesId;
  String? notesTitle;
  String? noteContent;
  String? noteImage;
  int? noteUsers;

  NoteModel(
      {this.notesId,
      this.notesTitle,
      this.noteContent,
      this.noteImage,
      this.noteUsers});

  NoteModel.fromJson(Map<String, dynamic> json) {
    notesId     = json['notes_id'];
    notesTitle  = json['notes_title'];
    noteContent = json['note_content'];
    noteImage   = json['note_image'];
    noteUsers   = json['note_users'];
  }

  /* Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notes_id'] = this.notesId;
    data['notes_title'] = this.notesTitle;
    data['note_content'] = this.noteContent;
    data['note_image'] = this.noteImage;
    data['note_users'] = this.noteUsers;
    return data;
  } */
}