create or replace view aggView1326366311626692350 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin3121606853864618640 as select movie_id as v12 from movie_companies as mc, aggView1326366311626692350 where mc.company_id=aggView1326366311626692350.v1;
create or replace view aggView6783383292476894535 as select id as v12, title as v31 from title as t;
create or replace view aggJoin2023764884027554028 as select v12, v31 from aggJoin3121606853864618640 join aggView6783383292476894535 using(v12);
create or replace view aggView2927154614326286400 as select v12, MIN(v31) as v31 from aggJoin2023764884027554028 group by v12;
create or replace view aggJoin3711349450029933314 as select keyword_id as v18, v31 from movie_keyword as mk, aggView2927154614326286400 where mk.movie_id=aggView2927154614326286400.v12;
create or replace view aggView2790309489240014619 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8950351629027024240 as select v31 from aggJoin3711349450029933314 join aggView2790309489240014619 using(v18);
select MIN(v31) as v31 from aggJoin8950351629027024240;
