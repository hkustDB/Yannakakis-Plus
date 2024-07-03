create or replace view aggView7109161735191408037 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin8577312770042796678 as select movie_id as v12 from movie_companies as mc, aggView7109161735191408037 where mc.company_id=aggView7109161735191408037.v1;
create or replace view aggView4170699457371960660 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8758567253948776742 as select movie_id as v12 from movie_keyword as mk, aggView4170699457371960660 where mk.keyword_id=aggView4170699457371960660.v18;
create or replace view aggView1078717777869116256 as select v12 from aggJoin8577312770042796678 group by v12;
create or replace view aggJoin910719738359244929 as select v12 from aggJoin8758567253948776742 join aggView1078717777869116256 using(v12);
create or replace view aggView4672131995648881188 as select id as v12, title as v31 from title as t;
create or replace view aggJoin6813217092616846187 as select v31 from aggJoin910719738359244929 join aggView4672131995648881188 using(v12);
select MIN(v31) as v31 from aggJoin6813217092616846187;
