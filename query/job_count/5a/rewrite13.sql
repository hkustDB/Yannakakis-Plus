create or replace view aggView1632509709461222002 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin152376779365188867 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1632509709461222002 where mc.company_type_id=aggView1632509709461222002.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView3265367074064776182 as select v15, COUNT(*) as annot from aggJoin152376779365188867 group by v15;
create or replace view aggJoin7132229352657603742 as select movie_id as v15, info_type_id as v3, info as v13, annot from movie_info as mi, aggView3265367074064776182 where mi.movie_id=aggView3265367074064776182.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView4857299625421401182 as select id as v3 from info_type as it;
create or replace view aggJoin2767459266227196151 as select v15, v13, annot from aggJoin7132229352657603742 join aggView4857299625421401182 using(v3);
create or replace view aggView8438167917129113993 as select v15, SUM(annot) as annot from aggJoin2767459266227196151 group by v15;
create or replace view aggJoin2328813876373604002 as select annot from title as t, aggView8438167917129113993 where t.id=aggView8438167917129113993.v15 and production_year>2005;
select SUM(annot) as v27 from aggJoin2328813876373604002;
