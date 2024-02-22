create or replace view aggView6326188391125752430 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin385128676185266841 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6326188391125752430 where Message_hasTag_Tag.MessageId=aggView6326188391125752430.v1;
create or replace view aggView1107732959364523882 as select v1, SUM(annot) as annot from aggJoin385128676185266841 group by v1;
create or replace view aggJoin7861888905714182725 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1107732959364523882 where Message_hasCreator_Person.MessageId=aggView1107732959364523882.v1;
create or replace view aggView4432916670467186527 as select v1, SUM(annot) as annot from aggJoin7861888905714182725 group by v1;
create or replace view aggJoin1810927315290313405 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4432916670467186527 where Comment_replyOf_Message.ParentMessageId=aggView4432916670467186527.v1;
select SUM(annot) as v9 from aggJoin1810927315290313405;
