create or replace view aggView7337406987431261009 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1092212653718735576 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7337406987431261009 where mc.company_type_id=aggView7337406987431261009.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView4197390565706682618 as select v15 from aggJoin1092212653718735576 group by v15;
create or replace view aggJoin8769046175929588346 as select id as v15, title as v16 from title as t, aggView4197390565706682618 where t.id=aggView4197390565706682618.v15 and production_year>2005;
create or replace view aggView5200087860195434794 as select v15, MIN(v16) as v27 from aggJoin8769046175929588346 group by v15;
create or replace view aggJoin3308087360157509906 as select info_type_id as v3, v27 from movie_info as mi, aggView5200087860195434794 where mi.movie_id=aggView5200087860195434794.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView7887681972422317703 as select v3, MIN(v27) as v27 from aggJoin3308087360157509906 group by v3;
create or replace view aggJoin2035216214990394575 as select v27 from info_type as it, aggView7887681972422317703 where it.id=aggView7887681972422317703.v3;
select MIN(v27) as v27 from aggJoin2035216214990394575;
