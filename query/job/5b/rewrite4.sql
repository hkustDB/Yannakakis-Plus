create or replace view aggView985832013061318323 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin903221935316825679 as select movie_id as v15, note as v9 from movie_companies as mc, aggView985832013061318323 where mc.company_type_id=aggView985832013061318323.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView5057174765334084508 as select v15 from aggJoin903221935316825679 group by v15;
create or replace view aggJoin8653340236165395317 as select id as v15, title as v16, production_year as v19 from title as t, aggView5057174765334084508 where t.id=aggView5057174765334084508.v15 and production_year>2010;
create or replace view aggView3788639146366505385 as select v15, MIN(v16) as v27 from aggJoin8653340236165395317 group by v15;
create or replace view aggJoin3340913864767545285 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView3788639146366505385 where mi.movie_id=aggView3788639146366505385.v15 and info IN ('USA','America');
create or replace view aggView1233735843520048820 as select id as v3 from info_type as it;
create or replace view aggJoin4798991888509992614 as select v27 from aggJoin3340913864767545285 join aggView1233735843520048820 using(v3);
select MIN(v27) as v27 from aggJoin4798991888509992614;
