create or replace view aggView2759352185680249389 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin7667093303059222850 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2759352185680249389 where Comment_replyOf_Message.ParentMessageId=aggView2759352185680249389.v1;
create or replace view aggView8475998534420161202 as select v1, SUM(annot) as annot from aggJoin7667093303059222850 group by v1;
create or replace view aggJoin1279591629060396867 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8475998534420161202 where Message_hasCreator_Person.MessageId=aggView8475998534420161202.v1;
create or replace view aggView7483678232202365778 as select v1, SUM(annot) as annot from aggJoin1279591629060396867 group by v1;
create or replace view aggJoin4211219976449612049 as select annot from Person_likes_Message as Person_likes_Message, aggView7483678232202365778 where Person_likes_Message.MessageId=aggView7483678232202365778.v1;
select SUM(annot) as v9 from aggJoin4211219976449612049;
