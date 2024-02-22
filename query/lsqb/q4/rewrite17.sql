create or replace view aggView1966072096762635958 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin2246238098958087266 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView1966072096762635958 where Message_hasTag_Tag.MessageId=aggView1966072096762635958.v1;
create or replace view aggView8778559065910968771 as select v1, SUM(annot) as annot from aggJoin2246238098958087266 group by v1;
create or replace view aggJoin8935963266781954507 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8778559065910968771 where Comment_replyOf_Message.ParentMessageId=aggView8778559065910968771.v1;
create or replace view aggView5633910833406625612 as select v1, SUM(annot) as annot from aggJoin8935963266781954507 group by v1;
create or replace view aggJoin4800035459047277671 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5633910833406625612 where Message_hasCreator_Person.MessageId=aggView5633910833406625612.v1;
select SUM(annot) as v9 from aggJoin4800035459047277671;
