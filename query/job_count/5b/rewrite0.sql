create or replace view aggView7871225784584753630 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3418847855331387916 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7871225784584753630 where mc.company_type_id=aggView7871225784584753630.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView403767944440751960 as select v15, COUNT(*) as annot from aggJoin3418847855331387916 group by v15;
create or replace view aggJoin2054928268259545757 as select id as v15, production_year as v19, annot from title as t, aggView403767944440751960 where t.id=aggView403767944440751960.v15 and production_year>2010;
create or replace view aggView7230804815460115848 as select v15, SUM(annot) as annot from aggJoin2054928268259545757 group by v15;
create or replace view aggJoin706560967838358928 as select info_type_id as v3, info as v13, annot from movie_info as mi, aggView7230804815460115848 where mi.movie_id=aggView7230804815460115848.v15 and info IN ('USA','America');
create or replace view aggView4367822301437965036 as select v3, SUM(annot) as annot from aggJoin706560967838358928 group by v3;
create or replace view aggJoin1751798080384774663 as select annot from info_type as it, aggView4367822301437965036 where it.id=aggView4367822301437965036.v3;
select SUM(annot) as v27 from aggJoin1751798080384774663;
