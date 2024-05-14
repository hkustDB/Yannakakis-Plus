create or replace view aggView7812076717140512080 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin5792096295445295798 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView7812076717140512080 where Message_hasCreator_Person.MessageId=aggView7812076717140512080.v1;
create or replace view aggView574288592501362562 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin9094730424615019767 as select v1, aggJoin5792096295445295798.annot * aggView574288592501362562.annot as annot from aggJoin5792096295445295798 join aggView574288592501362562 using(v1);
create or replace view aggView5556564710129633474 as select v1, SUM(annot) as annot from aggJoin9094730424615019767 group by v1;
create or replace view aggJoin7641181127512191885 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView5556564710129633474 where Message_hasTag_Tag.MessageId=aggView5556564710129633474.v1;
select SUM(annot) as v9 from aggJoin7641181127512191885;
