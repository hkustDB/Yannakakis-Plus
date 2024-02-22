create or replace view aggView5013264832400045601 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin6098217304991882 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView5013264832400045601 where Person_likes_Message.MessageId=aggView5013264832400045601.v1;
create or replace view aggView4342476788998092281 as select v1, SUM(annot) as annot from aggJoin6098217304991882 group by v1;
create or replace view aggJoin1162545533024730224 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4342476788998092281 where Comment_replyOf_Message.ParentMessageId=aggView4342476788998092281.v1;
create or replace view aggView38217165264535765 as select v1, SUM(annot) as annot from aggJoin1162545533024730224 group by v1;
create or replace view aggJoin95823705275628622 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView38217165264535765 where Message_hasTag_Tag.MessageId=aggView38217165264535765.v1;
select SUM(annot) as v9 from aggJoin95823705275628622;
