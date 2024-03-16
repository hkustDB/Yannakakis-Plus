create or replace view aggView8760121333850944922 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2772966639296843224 as select movie_id as v12 from movie_keyword as mk, aggView8760121333850944922 where mk.keyword_id=aggView8760121333850944922.v18;
create or replace view aggView5477657888087926631 as select v12 from aggJoin2772966639296843224 group by v12;
create or replace view aggJoin8256584497317019733 as select id as v12, title as v20 from title as t, aggView5477657888087926631 where t.id=aggView5477657888087926631.v12;
create or replace view aggView106229867645598370 as select v12, MIN(v20) as v31 from aggJoin8256584497317019733 group by v12;
create or replace view aggJoin2941357642790770681 as select company_id as v1, v31 from movie_companies as mc, aggView106229867645598370 where mc.movie_id=aggView106229867645598370.v12;
create or replace view aggView2808428061758975331 as select v1, MIN(v31) as v31 from aggJoin2941357642790770681 group by v1;
create or replace view aggJoin2337706873892689666 as select country_code as v3, v31 from company_name as cn, aggView2808428061758975331 where cn.id=aggView2808428061758975331.v1 and country_code= '[us]';
select MIN(v31) as v31 from aggJoin2337706873892689666;
