create or replace view aggView521562336020684469 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin4233372310924922293 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView521562336020684469 where Comment_replyOf_Message.ParentMessageId=aggView521562336020684469.v1;
create or replace view aggView7713603172506601423 as select v1, SUM(annot) as annot from aggJoin4233372310924922293 group by v1;
create or replace view aggJoin653467860636416980 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView7713603172506601423 where Message_hasCreator_Person.MessageId=aggView7713603172506601423.v1;
create or replace view aggView8687479334080138387 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin3098737745606043630 as select aggJoin653467860636416980.annot * aggView8687479334080138387.annot as annot from aggJoin653467860636416980 join aggView8687479334080138387 using(v1);
select SUM(annot) as v9 from aggJoin3098737745606043630;
