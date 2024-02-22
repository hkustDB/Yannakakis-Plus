create or replace view aggView864548031032704370 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin5809053818419867682 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView864548031032704370 where Message_hasTag_Tag.MessageId=aggView864548031032704370.v1;
create or replace view aggView3696759621227388491 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin6836823449194173864 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3696759621227388491 where Comment_replyOf_Message.ParentMessageId=aggView3696759621227388491.v1;
create or replace view aggView218450682999111189 as select v1, SUM(annot) as annot from aggJoin6836823449194173864 group by v1;
create or replace view aggJoin7882558652524686049 as select aggJoin5809053818419867682.annot * aggView218450682999111189.annot as annot from aggJoin5809053818419867682 join aggView218450682999111189 using(v1);
select SUM(annot) as v9 from aggJoin7882558652524686049;
