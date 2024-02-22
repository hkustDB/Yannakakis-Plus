create or replace view aggView7758494149898581184 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin3192789634693967352 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView7758494149898581184 where Message_hasCreator_Person.MessageId=aggView7758494149898581184.v1;
create or replace view aggView2311447432840014273 as select v1, SUM(annot) as annot from aggJoin3192789634693967352 group by v1;
create or replace view aggJoin2037761545878129730 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView2311447432840014273 where Message_hasTag_Tag.MessageId=aggView2311447432840014273.v1;
create or replace view aggView977030662599860848 as select v1, SUM(annot) as annot from aggJoin2037761545878129730 group by v1;
create or replace view aggJoin6226058566595591129 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView977030662599860848 where Comment_replyOf_Message.ParentMessageId=aggView977030662599860848.v1;
select SUM(annot) as v9 from aggJoin6226058566595591129;
