create or replace view aggView5967502813736259611 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin1157646961256605573 as select movie_id as v12 from movie_companies as mc, aggView5967502813736259611 where mc.company_id=aggView5967502813736259611.v1;
create or replace view aggView5625905337339027893 as select v12 from aggJoin1157646961256605573 group by v12;
create or replace view aggJoin3046014011969002037 as select id as v12, title as v20 from title as t, aggView5625905337339027893 where t.id=aggView5625905337339027893.v12;
create or replace view aggView7265286862142519924 as select v12, MIN(v20) as v31 from aggJoin3046014011969002037 group by v12;
create or replace view aggJoin3631851837516409052 as select keyword_id as v18, v31 from movie_keyword as mk, aggView7265286862142519924 where mk.movie_id=aggView7265286862142519924.v12;
create or replace view aggView3491970068468795559 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8420883591495639343 as select v31 from aggJoin3631851837516409052 join aggView3491970068468795559 using(v18);
select MIN(v31) as v31 from aggJoin8420883591495639343;
