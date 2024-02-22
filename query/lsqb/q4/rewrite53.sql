create or replace view aggView5600108120752231509 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin5652513128893761527 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5600108120752231509 where Message_hasCreator_Person.MessageId=aggView5600108120752231509.v1;
create or replace view aggView896754119593915771 as select v1, SUM(annot) as annot from aggJoin5652513128893761527 group by v1;
create or replace view aggJoin4445743898400897476 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView896754119593915771 where Person_likes_Message.MessageId=aggView896754119593915771.v1;
create or replace view aggView5034094342768236529 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin2948680122784681387 as select aggJoin4445743898400897476.annot * aggView5034094342768236529.annot as annot from aggJoin4445743898400897476 join aggView5034094342768236529 using(v1);
select SUM(annot) as v9 from aggJoin2948680122784681387;
