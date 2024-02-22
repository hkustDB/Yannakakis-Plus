create or replace view aggView3384966114710723081 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin5875595145193120614 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView3384966114710723081 where Person_likes_Message.MessageId=aggView3384966114710723081.v1;
create or replace view aggView3345967456684702018 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin3718947485303023128 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3345967456684702018 where Message_hasCreator_Person.MessageId=aggView3345967456684702018.v1;
create or replace view aggView3874829792646962037 as select v1, SUM(annot) as annot from aggJoin3718947485303023128 group by v1;
create or replace view aggJoin1989328013792084084 as select aggJoin5875595145193120614.annot * aggView3874829792646962037.annot as annot from aggJoin5875595145193120614 join aggView3874829792646962037 using(v1);
select SUM(annot) as v9 from aggJoin1989328013792084084;
