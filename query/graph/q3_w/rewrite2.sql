
create or replace view g1 as select wiki.src as v7, wiki.dst as v2, v8 from wiki, (SELECT src, COUNT(*) AS v8 FROM wiki GROUP BY src) AS c1 where wiki.src = c1.src;
create or replace view g2 as select wiki.src as v2, wiki.dst as v4, v12 from wiki, (SELECT src, COUNT(*) AS v12 FROM wiki GROUP BY src) AS c3 where wiki.src = c3.src;
create or replace view orderView798430919106563119 as select v7, v2, v8, row_number() over (partition by v2 order by v8) as rn from g1;
create or replace view minView4087590727989022274 as select v2, v8 as mfL1632864140027079100 from orderView798430919106563119 where rn = 1;
create or replace view joinView3834482132001083096 as select v2, v4, v12, mfL1632864140027079100 from g2 join minView4087590727989022274 using(v2);
create or replace view g3 as select wiki.src as v4, wiki.dst as v9, v10, v14 from wiki, (SELECT src, COUNT(*) AS v10 FROM wiki GROUP BY src) AS c2, (SELECT dst, COUNT(*) AS v14 FROM wiki GROUP BY dst) AS c4 where wiki.dst = c2.src and wiki.dst = c4.dst;
create or replace view orderView2327969131291024343 as select v2, v4, v12, mfL1632864140027079100, row_number() over (partition by v4 order by mfL1632864140027079100) as rn from joinView3834482132001083096;
create or replace view minView6616171631384632344 as select v4, mfL1632864140027079100 as mfL6381769536451792279 from orderView2327969131291024343 where rn = 1;
create or replace view joinView1085041706562003862 as select v4, v9, v10, v14, mfL6381769536451792279 from g3 join minView6616171631384632344 using(v4) where mfL6381769536451792279<v10;
create or replace view sample2573243114057466878 as select * from orderView2327969131291024343 where rn % 100 = 1;
create or replace view maxRn8307096391128887838 as select v4, max(rn) as mrn from joinView1085041706562003862 join sample2573243114057466878 using(v4) where mfL1632864140027079100<v10 group by v4;
create or replace view target1703806871603934643 as select v2, v4, v12, mfL1632864140027079100 from orderView2327969131291024343 join maxRn8307096391128887838 using(v4) where rn < mrn + 5;
create or replace view end8423970138890953391 as select v9, v10, v2, v14, v12, v4, mfL1632864140027079100 from joinView1085041706562003862 join target1703806871603934643 using(v4) where mfL1632864140027079100<v10 and v12<v14;
create or replace view sample6738302485587786680 as select * from orderView798430919106563119 where rn % 100 = 1;
create or replace view maxRn1263614037254432565 as select v2, max(rn) as mrn from end8423970138890953391 join sample6738302485587786680 using(v2) where v8<v10 group by v2;
create or replace view target126849801023506323 as select v7, v2, v8 from orderView798430919106563119 join maxRn1263614037254432565 using(v2) where rn < mrn + 5;
create or replace view end5582546326540297322 as select v8, v9, v10, v2, v14, v12, v4, v7 from end8423970138890953391 join target126849801023506323 using(v2) where v8<v10;
/*+QUERY_TIMEOUT=86400000*/select sum(v2+v4+v7+v8+v9+v10+v12+v14) from end5582546326540297322;
