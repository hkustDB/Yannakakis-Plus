create or replace view aggView5283198196007536429 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7430014345478382992 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5283198196007536429 where mc.company_type_id=aggView5283198196007536429.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView7228932317995105397 as select v15 from aggJoin7430014345478382992 group by v15;
create or replace view aggJoin1933532370577298134 as select id as v15, title as v16 from title as t, aggView7228932317995105397 where t.id=aggView7228932317995105397.v15 and production_year>2010;
create or replace view aggView3321923166406096049 as select v15, MIN(v16) as v27 from aggJoin1933532370577298134 group by v15;
create or replace view aggJoin2954355231713617006 as select info_type_id as v3, v27 from movie_info as mi, aggView3321923166406096049 where mi.movie_id=aggView3321923166406096049.v15 and info IN ('USA','America');
create or replace view aggView1190157722165875442 as select v3, MIN(v27) as v27 from aggJoin2954355231713617006 group by v3;
create or replace view aggJoin103415549134684454 as select v27 from info_type as it, aggView1190157722165875442 where it.id=aggView1190157722165875442.v3;
select MIN(v27) as v27 from aggJoin103415549134684454;
