create or replace view aggView5969144782017652504 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin7818021802265703627 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView5969144782017652504 where Person_likes_Message.MessageId=aggView5969144782017652504.v1;
create or replace view aggView868124165663722463 as select v1, SUM(annot) as annot from aggJoin7818021802265703627 group by v1;
create or replace view aggJoin2253575350485831555 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView868124165663722463 where Message_hasTag_Tag.MessageId=aggView868124165663722463.v1;
create or replace view aggView5730559987015065308 as select v1, SUM(annot) as annot from aggJoin2253575350485831555 group by v1;
create or replace view aggJoin4645796326935688531 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5730559987015065308 where Comment_replyOf_Message.ParentMessageId=aggView5730559987015065308.v1;
select SUM(annot) as v9 from aggJoin4645796326935688531;
