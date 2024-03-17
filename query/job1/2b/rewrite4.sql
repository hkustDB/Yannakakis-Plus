create or replace view aggView4879645903677695125 as select id as v12, title as v31 from title as t;
create or replace view aggJoin7398589263533491400 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView4879645903677695125 where mk.movie_id=aggView4879645903677695125.v12;
create or replace view aggView3379681830862360344 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin494305695122010765 as select movie_id as v12 from movie_companies as mc, aggView3379681830862360344 where mc.company_id=aggView3379681830862360344.v1;
create or replace view aggView6513095635307713714 as select v12 from aggJoin494305695122010765 group by v12;
create or replace view aggJoin4509055220236916662 as select v18, v31 as v31 from aggJoin7398589263533491400 join aggView6513095635307713714 using(v12);
create or replace view aggView7732602550043969066 as select v18, MIN(v31) as v31 from aggJoin4509055220236916662 group by v18;
create or replace view aggJoin973273989420014284 as select keyword as v9, v31 from keyword as k, aggView7732602550043969066 where k.id=aggView7732602550043969066.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin973273989420014284;
