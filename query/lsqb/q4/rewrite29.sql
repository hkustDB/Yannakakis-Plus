create or replace view aggView2738780657209130157 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin2525135899744458951 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView2738780657209130157 where Message_hasCreator_Person.MessageId=aggView2738780657209130157.v1;
create or replace view aggView3119798565763192590 as select v1, SUM(annot) as annot from aggJoin2525135899744458951 group by v1;
create or replace view aggJoin9164546912507753495 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3119798565763192590 where Message_hasTag_Tag.MessageId=aggView3119798565763192590.v1;
create or replace view aggView7653530471661040048 as select v1, SUM(annot) as annot from aggJoin9164546912507753495 group by v1;
create or replace view aggJoin7921175359916344816 as select annot from Person_likes_Message as Person_likes_Message, aggView7653530471661040048 where Person_likes_Message.MessageId=aggView7653530471661040048.v1;
select SUM(annot) as v9 from aggJoin7921175359916344816;
