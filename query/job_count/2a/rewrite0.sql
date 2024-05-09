create or replace view aggView2394575144039234528 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin4656281781702174375 as select movie_id as v12 from movie_companies as mc, aggView2394575144039234528 where mc.company_id=aggView2394575144039234528.v1;
create or replace view aggView6984439818463123252 as select v12, COUNT(*) as annot from aggJoin4656281781702174375 group by v12;
create or replace view aggJoin7482431825892840687 as select id as v12, annot from title as t, aggView6984439818463123252 where t.id=aggView6984439818463123252.v12;
create or replace view aggView2001458014166482403 as select v12, SUM(annot) as annot from aggJoin7482431825892840687 group by v12;
create or replace view aggJoin156060770068775546 as select keyword_id as v18, annot from movie_keyword as mk, aggView2001458014166482403 where mk.movie_id=aggView2001458014166482403.v12;
create or replace view aggView5931911727450586452 as select v18, SUM(annot) as annot from aggJoin156060770068775546 group by v18;
create or replace view aggJoin2280795395521427565 as select keyword as v9, annot from keyword as k, aggView5931911727450586452 where k.id=aggView5931911727450586452.v18 and keyword= 'character-name-in-title';
select SUM(annot) as v31 from aggJoin2280795395521427565;
