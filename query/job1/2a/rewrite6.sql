create or replace view aggView1892904404926690979 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin9015138563355481815 as select movie_id as v12 from movie_companies as mc, aggView1892904404926690979 where mc.company_id=aggView1892904404926690979.v1;
create or replace view aggView6692719304302968134 as select v12 from aggJoin9015138563355481815 group by v12;
create or replace view aggJoin1505203362275733361 as select id as v12, title as v20 from title as t, aggView6692719304302968134 where t.id=aggView6692719304302968134.v12;
create or replace view aggView2411644360034216226 as select v12, MIN(v20) as v31 from aggJoin1505203362275733361 group by v12;
create or replace view aggJoin5760956829993891428 as select keyword_id as v18, v31 from movie_keyword as mk, aggView2411644360034216226 where mk.movie_id=aggView2411644360034216226.v12;
create or replace view aggView3674437565390870791 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1299632776739023117 as select v31 from aggJoin5760956829993891428 join aggView3674437565390870791 using(v18);
select MIN(v31) as v31 from aggJoin1299632776739023117;
