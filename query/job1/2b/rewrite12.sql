create or replace view aggView6876497567907028979 as select id as v12, title as v31 from title as t;
create or replace view aggJoin3897975031988239314 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView6876497567907028979 where mk.movie_id=aggView6876497567907028979.v12;
create or replace view aggView7245983747838774085 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin5879512804656376144 as select movie_id as v12 from movie_companies as mc, aggView7245983747838774085 where mc.company_id=aggView7245983747838774085.v1;
create or replace view aggView2494048843459180215 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7154376051189158878 as select v12, v31 from aggJoin3897975031988239314 join aggView2494048843459180215 using(v18);
create or replace view aggView9055256106588924268 as select v12, MIN(v31) as v31 from aggJoin7154376051189158878 group by v12;
create or replace view aggJoin1856564300661770976 as select v31 from aggJoin5879512804656376144 join aggView9055256106588924268 using(v12);
select MIN(v31) as v31 from aggJoin1856564300661770976;
