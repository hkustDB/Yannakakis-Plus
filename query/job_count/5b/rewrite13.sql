create or replace view aggView1370874069228069965 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin9134072609272689238 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1370874069228069965 where mc.company_type_id=aggView1370874069228069965.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView645751460772875411 as select id as v15 from title as t where production_year>2010;
create or replace view aggJoin3961095643402247340 as select v15, v9 from aggJoin9134072609272689238 join aggView645751460772875411 using(v15);
create or replace view aggView8833545387383296021 as select v15, COUNT(*) as annot from aggJoin3961095643402247340 group by v15;
create or replace view aggJoin3056787549454811839 as select info_type_id as v3, info as v13, annot from movie_info as mi, aggView8833545387383296021 where mi.movie_id=aggView8833545387383296021.v15 and info IN ('USA','America');
create or replace view aggView1407295883568967479 as select id as v3 from info_type as it;
create or replace view aggJoin9057964983597853302 as select annot from aggJoin3056787549454811839 join aggView1407295883568967479 using(v3);
select SUM(annot) as v27 from aggJoin9057964983597853302;
