create or replace view aggView3006924167700764227 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin7921243980551331431 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView3006924167700764227 where Person_likes_Message.MessageId=aggView3006924167700764227.v1;
create or replace view aggView814339148664146011 as select v1, SUM(annot) as annot from aggJoin7921243980551331431 group by v1;
create or replace view aggJoin5742725379375319526 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView814339148664146011 where Comment_replyOf_Message.ParentMessageId=aggView814339148664146011.v1;
create or replace view aggView4352496680315209590 as select v1, SUM(annot) as annot from aggJoin5742725379375319526 group by v1;
create or replace view aggJoin5996377150445898850 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView4352496680315209590 where Message_hasCreator_Person.MessageId=aggView4352496680315209590.v1;
select SUM(annot) as v9 from aggJoin5996377150445898850;
