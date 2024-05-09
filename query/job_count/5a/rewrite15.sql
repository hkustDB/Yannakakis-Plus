create or replace view aggView2109921436438809568 as select id as v3 from info_type as it;
create or replace view aggJoin4168076004716265561 as select movie_id as v15, info as v13 from movie_info as mi, aggView2109921436438809568 where mi.info_type_id=aggView2109921436438809568.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView1337004093505311803 as select v15, COUNT(*) as annot from aggJoin4168076004716265561 group by v15;
create or replace view aggJoin6081824746649190850 as select movie_id as v15, company_type_id as v1, note as v9, annot from movie_companies as mc, aggView1337004093505311803 where mc.movie_id=aggView1337004093505311803.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView3585963938454845755 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2158866985810050057 as select v15, v9, annot from aggJoin6081824746649190850 join aggView3585963938454845755 using(v1);
create or replace view aggView7664997083909860878 as select v15, SUM(annot) as annot from aggJoin2158866985810050057 group by v15;
create or replace view aggJoin6640896371096593545 as select annot from title as t, aggView7664997083909860878 where t.id=aggView7664997083909860878.v15 and production_year>2005;
select SUM(annot) as v27 from aggJoin6640896371096593545;
