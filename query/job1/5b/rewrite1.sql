create or replace view aggView3285125814815738791 as select id as v3 from info_type as it;
create or replace view aggJoin1233853252428624006 as select movie_id as v15, info as v13 from movie_info as mi, aggView3285125814815738791 where mi.info_type_id=aggView3285125814815738791.v3 and info IN ('USA','America');
create or replace view aggView8985237352508175181 as select v15 from aggJoin1233853252428624006 group by v15;
create or replace view aggJoin3962053797959628054 as select id as v15, title as v16 from title as t, aggView8985237352508175181 where t.id=aggView8985237352508175181.v15 and production_year>2010;
create or replace view aggView733159411242029543 as select v15, MIN(v16) as v27 from aggJoin3962053797959628054 group by v15;
create or replace view aggJoin9016274352638633086 as select company_type_id as v1, v27 from movie_companies as mc, aggView733159411242029543 where mc.movie_id=aggView733159411242029543.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView7267660830493811339 as select v1, MIN(v27) as v27 from aggJoin9016274352638633086 group by v1;
create or replace view aggJoin6233083680777688049 as select v27 from company_type as ct, aggView7267660830493811339 where ct.id=aggView7267660830493811339.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin6233083680777688049;
