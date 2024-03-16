create or replace view aggView400019440810751877 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin8055593215829190089 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView400019440810751877 where mc.movie_id=aggView400019440810751877.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView1955100287883637106 as select id as v3 from info_type as it;
create or replace view aggJoin9143080022154209308 as select movie_id as v15, info as v13 from movie_info as mi, aggView1955100287883637106 where mi.info_type_id=aggView1955100287883637106.v3 and info IN ('USA','America');
create or replace view aggView5864622592045258721 as select v15 from aggJoin9143080022154209308 group by v15;
create or replace view aggJoin9011942470601897408 as select v1, v9, v27 as v27 from aggJoin8055593215829190089 join aggView5864622592045258721 using(v15);
create or replace view aggView3166884898334205768 as select v1, MIN(v27) as v27 from aggJoin9011942470601897408 group by v1;
create or replace view aggJoin2893133433737078390 as select kind as v2, v27 from company_type as ct, aggView3166884898334205768 where ct.id=aggView3166884898334205768.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin2893133433737078390;
