create or replace view aggView1081190189509273086 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin2084752994497239144 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView1081190189509273086 where mi.movie_id=aggView1081190189509273086.v15 and info IN ('USA','America');
create or replace view aggView4382806007445989856 as select id as v3 from info_type as it;
create or replace view aggJoin1094225763694537295 as select v15, v13, v27 from aggJoin2084752994497239144 join aggView4382806007445989856 using(v3);
create or replace view aggView4514080127323975709 as select v15, MIN(v27) as v27 from aggJoin1094225763694537295 group by v15;
create or replace view aggJoin2321556154645545191 as select company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView4514080127323975709 where mc.movie_id=aggView4514080127323975709.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView7606419605068951965 as select v1, MIN(v27) as v27 from aggJoin2321556154645545191 group by v1;
create or replace view aggJoin1560783339561951939 as select kind as v2, v27 from company_type as ct, aggView7606419605068951965 where ct.id=aggView7606419605068951965.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin1560783339561951939;
