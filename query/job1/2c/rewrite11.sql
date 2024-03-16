create or replace view aggView6541906289434845695 as select id as v12, title as v31 from title as t;
create or replace view aggJoin5849986656151199266 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView6541906289434845695 where mc.movie_id=aggView6541906289434845695.v12;
create or replace view aggView1917972910273751758 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin5996838677000647616 as select v12, v31 from aggJoin5849986656151199266 join aggView1917972910273751758 using(v1);
create or replace view aggView2726402669962245427 as select v12, MIN(v31) as v31 from aggJoin5996838677000647616 group by v12;
create or replace view aggJoin7510954135702115639 as select keyword_id as v18, v31 from movie_keyword as mk, aggView2726402669962245427 where mk.movie_id=aggView2726402669962245427.v12;
create or replace view aggView4083921487560027818 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6642110886422520681 as select v31 from aggJoin7510954135702115639 join aggView4083921487560027818 using(v18);
select MIN(v31) as v31 from aggJoin6642110886422520681;
