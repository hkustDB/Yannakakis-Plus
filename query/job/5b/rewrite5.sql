create or replace view aggView4538061167212934473 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin9062637628565215677 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView4538061167212934473 where mi.movie_id=aggView4538061167212934473.v15 and info IN ('USA','America');
create or replace view aggView1493422609316708476 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2833674590864161361 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1493422609316708476 where mc.company_type_id=aggView1493422609316708476.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView9179572840585296741 as select v15 from aggJoin2833674590864161361 group by v15;
create or replace view aggJoin4746273508499769369 as select v3, v13, v27 as v27 from aggJoin9062637628565215677 join aggView9179572840585296741 using(v15);
create or replace view aggView1520960946986218958 as select id as v3 from info_type as it;
create or replace view aggJoin2779038002145464703 as select v27 from aggJoin4746273508499769369 join aggView1520960946986218958 using(v3);
select MIN(v27) as v27 from aggJoin2779038002145464703;
