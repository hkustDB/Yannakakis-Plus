create or replace view aggView5357959763355207236 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin504247010897527590 as select movie_id as v12 from movie_companies as mc, aggView5357959763355207236 where mc.company_id=aggView5357959763355207236.v1;
create or replace view aggView6327654726515090700 as select id as v12, title as v31 from title as t;
create or replace view aggJoin2812508311482653088 as select v12, v31 from aggJoin504247010897527590 join aggView6327654726515090700 using(v12);
create or replace view aggView4896685652067818869 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7913333458759604389 as select movie_id as v12 from movie_keyword as mk, aggView4896685652067818869 where mk.keyword_id=aggView4896685652067818869.v18;
create or replace view aggView6865916252763875570 as select v12, MIN(v31) as v31 from aggJoin2812508311482653088 group by v12,v31;
create or replace view aggJoin3402779836789352740 as select v31 from aggJoin7913333458759604389 join aggView6865916252763875570 using(v12);
select MIN(v31) as v31 from aggJoin3402779836789352740;
