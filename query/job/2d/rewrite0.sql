create or replace view aggView7189788430800502264 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5649566672959257259 as select movie_id as v12 from movie_keyword as mk, aggView7189788430800502264 where mk.keyword_id=aggView7189788430800502264.v18;
create or replace view aggView5865215750093655972 as select v12 from aggJoin5649566672959257259 group by v12;
create or replace view aggJoin583285861126872613 as select id as v12, title as v20 from title as t, aggView5865215750093655972 where t.id=aggView5865215750093655972.v12;
create or replace view aggView4921567580234555252 as select v12, MIN(v20) as v31 from aggJoin583285861126872613 group by v12;
create or replace view aggJoin5818766193642891009 as select company_id as v1, v31 from movie_companies as mc, aggView4921567580234555252 where mc.movie_id=aggView4921567580234555252.v12;
create or replace view aggView6299842401645250699 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin1123497508746536430 as select v31 from aggJoin5818766193642891009 join aggView6299842401645250699 using(v1);
select MIN(v31) as v31 from aggJoin1123497508746536430;
