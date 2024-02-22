create or replace view aggView3390868432007179086 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin2167601565700915937 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3390868432007179086 where Message_hasTag_Tag.MessageId=aggView3390868432007179086.v1;
create or replace view aggView2954314638969253460 as select v1, SUM(annot) as annot from aggJoin2167601565700915937 group by v1;
create or replace view aggJoin1633212309547963638 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView2954314638969253460 where Person_likes_Message.MessageId=aggView2954314638969253460.v1;
create or replace view aggView956855242773536533 as select v1, SUM(annot) as annot from aggJoin1633212309547963638 group by v1;
create or replace view aggJoin3763658362790807038 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView956855242773536533 where Comment_replyOf_Message.ParentMessageId=aggView956855242773536533.v1;
select SUM(annot) as v9 from aggJoin3763658362790807038;
