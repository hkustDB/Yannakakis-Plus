create or replace view aggView8915324015882099558 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin1721713520348828335 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8915324015882099558 where Message_hasCreator_Person.MessageId=aggView8915324015882099558.v1;
create or replace view aggView3413209034003502126 as select v1, SUM(annot) as annot from aggJoin1721713520348828335 group by v1;
create or replace view aggJoin4338095607971055806 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView3413209034003502126 where Person_likes_Message.MessageId=aggView3413209034003502126.v1;
create or replace view aggView5914829445859970970 as select v1, SUM(annot) as annot from aggJoin4338095607971055806 group by v1;
create or replace view aggJoin917302320038751494 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5914829445859970970 where Comment_replyOf_Message.ParentMessageId=aggView5914829445859970970.v1;
select SUM(annot) as v9 from aggJoin917302320038751494;
