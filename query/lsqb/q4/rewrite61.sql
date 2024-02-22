create or replace view aggView3431695418559076293 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin7810426293172416517 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3431695418559076293 where Message_hasCreator_Person.MessageId=aggView3431695418559076293.v1;
create or replace view aggView3594515622454592937 as select v1, SUM(annot) as annot from aggJoin7810426293172416517 group by v1;
create or replace view aggJoin8300995396423484488 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView3594515622454592937 where Person_likes_Message.MessageId=aggView3594515622454592937.v1;
create or replace view aggView8893159895760887657 as select v1, SUM(annot) as annot from aggJoin8300995396423484488 group by v1;
create or replace view aggJoin6255988080137996099 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8893159895760887657 where Message_hasTag_Tag.MessageId=aggView8893159895760887657.v1;
select SUM(annot) as v9 from aggJoin6255988080137996099;
