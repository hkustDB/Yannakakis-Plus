create or replace view aggView2266429776732713012 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin2302769330484145097 as select movie_id as v12 from movie_companies as mc, aggView2266429776732713012 where mc.company_id=aggView2266429776732713012.v1;
create or replace view aggView2945301739601243401 as select v12, COUNT(*) as annot from aggJoin2302769330484145097 group by v12;
create or replace view aggJoin2522521653383813503 as select id as v12, annot from title as t, aggView2945301739601243401 where t.id=aggView2945301739601243401.v12;
create or replace view aggView6189424478901895417 as select v12, SUM(annot) as annot from aggJoin2522521653383813503 group by v12;
create or replace view aggJoin811214550965402205 as select keyword_id as v18, annot from movie_keyword as mk, aggView6189424478901895417 where mk.movie_id=aggView6189424478901895417.v12;
create or replace view aggView3284983285059514715 as select v18, SUM(annot) as annot from aggJoin811214550965402205 group by v18;
create or replace view aggJoin7859999388451845761 as select keyword as v9, annot from keyword as k, aggView3284983285059514715 where k.id=aggView3284983285059514715.v18 and keyword= 'character-name-in-title';
select SUM(annot) as v31 from aggJoin7859999388451845761;
